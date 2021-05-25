<?php
require_once('./../smarty/Smarty.class.php');
session_start();
$smarty = new Smarty();
$db = new mysqli('localhost', 'root', '', 'farm');
$animalId;

$smarty->setTemplateDir('./../templates/admin');
$smarty->setCompileDir('./../templates_c');
$smarty->setCacheDir('./../cache');
$smarty->setConfigDir('./../configs');

if (isset($_SESSION['login']))
    $smarty->assign('login', $_SESSION['login']);

if (isset($_REQUEST['action'])) {
    switch ($_REQUEST['action']) {
        case 'processLogin':
            $query = $db->prepare("SELECT * FROM admin WHERE login = ? LIMIT 1");
            $query->bind_param("s", $_REQUEST['login']);
            $query->execute();
            $result = $query->get_result();
            if ($result->num_rows == 0) {
                $smarty->assign('error', "Błędny login lub hasło");
                $smarty->display('login.tpl');
                break;
            }
            $row = $result->fetch_assoc();
            if (password_verify($_REQUEST['password'], $row['password'])) {
                $_SESSION['userID'] = $row['id'];
                $_SESSION['login'] = $row['login'];
                $smarty->assign('login', $_SESSION['login']);
                $smarty->display('index.tpl');
            } else {
                $smarty->assign('error', "Błędny login lub hasło");
                $smarty->display('login.tpl');
            }
            break;
        case 'logout':
            session_destroy();
            header('Location: index.php');
            break;
        case 'employeeList':
            $query = $db->prepare("SELECT * FROM employee");
            $query->execute();
            $result = $query->get_result();
            $employees = array();
            while ($row = $result->fetch_assoc()) {
                array_push($employees, $row);
            }
            $smarty->assign('employees', $employees);
            $smarty->display('employees.tpl');
            break;
        case 'animalList':
            $query = $db->prepare("SELECT * FROM animal");
            $query->execute();
            $result = $query->get_result();
            $animals = array();

            while ($row = $result->fetch_assoc()) {
                array_push($animals, $row);
            }
            $smarty->assign('animals', $animals);
            $smarty->display('animals.tpl');
            break;
        case 'aboutAnimal':
            //animal display
            $query = $db->prepare("SELECT * FROM animal WHERE id=?");
            $query->bind_param('i', $_REQUEST['animal_id']);
            $query->execute();
                       
            $result = $query->get_result();
            $row = $result->fetch_assoc();

            $smarty->assign('animal', $row);
            //notes display
            $query = $db->prepare("SELECT n.id, n.title, n.content, n.createDate, n.employee_Id,
                                          e.firstName, e.lastName, e.occupation
                                   FROM animal AS a
                                   INNER JOIN note AS n
                                   ON a.id=n.animal_Id
                                   LEFT JOIN employee AS e
                                   ON e.id=n.employee_Id
                                   WHERE a.id=?;");
            $query->bind_param('i', $_REQUEST['animal_id']);
            $query->execute();
            $result = $query->get_result();
            $notes = array();
            while ($row = $result->fetch_assoc()) {
                array_push($notes, $row);
            }

            $smarty->assign('notes', $notes);
            $smarty->display('aboutAnimal.tpl');
            break;
        case 'generateWorkSchedule':
            $query = $db->prepare("SELECT * FROM employee");
            $query->execute();
            $result = $query->get_result();
            $employees = array();
            while ($row = $result->fetch_assoc()) {
                array_push($employees, $row);
            }
            $smarty->assign('employees', $employees);
            $smarty->display('generateWorkSchedules.tpl');

            break;
        case 'generateScheduleProcess':
            $shiftStart = strtotime($_REQUEST['shiftStart']);
            $shiftEnd = strtotime($_REQUEST['shiftEnd']);

            if ($shiftStart > $shiftEnd) {
                echo '<script>alert("Błędne dane, prosze poprawić!")</script>';
            }
            $datetime = new DateTime($_REQUEST['shiftEnd']);
            $datetime->modify('+1 day');

            $period = new DatePeriod(
                new DateTime($_REQUEST['shiftStart']),
                new DateInterval('P1D'),
                new DateTime($datetime->format('Y-m-d'))
            );
            $days = array();
            foreach ($period as $key => $value) {
                $value->format('Y-m-d');
                array_push($days, $value->format('Y-m-d'));
            }

            foreach ($days as $day) {
                echo $day;
                $query = $db->prepare("INSERT INTO `workschedule`
                                    (`id`, `shiftStart`, 
                                    `status`, `shiftTimeStart`, `shiftTimeEnd`, `employeeId`) 
                VALUES (NULL, ?, 0, ?, ?, ?)");
                $query->bind_param('sssi', $day,  $_REQUEST['shiftTimeStart'], $_REQUEST['shiftTimeEnd'],  $_REQUEST['employee']);
                $query->execute();
            }
            header('Location: index.php?action=generateWorkSchedule');

            break;


        case 'showWorkSchedule':
            //Current employee data
            $query = $db->prepare("SELECT * FROM employee WHERE id =?");
            $query->bind_param("i", $_REQUEST["employee_id"]);
            $query->execute();

            $result = $query->get_result();
            $row = $result->fetch_assoc();

            $smarty->assign('employee', $row);

            //Current employee's schedule
            $query = $db->prepare("SELECT workschedule.shiftStart, workschedule.status,
                                          workschedule.shiftTimeStart, workschedule.shiftTimeEnd
                                   FROM workschedule
                                   INNER JOIN employee 
                                   ON workschedule.employeeId=employee.id
                                   WHERE employee.id=?;");
            $query->bind_param("i", $_REQUEST["employee_id"]);
            $query->execute();

            $result = $query->get_result();
            $workschedules = array();
            while ($row = $result->fetch_assoc()) {
                array_push($workschedules, $row);
            }
            $smarty->assign('workschedules', $workschedules);

            $smarty->display('workSchedule.tpl');
            break;
        case 'addEmployeeProcess':
            $query = $db->prepare("INSERT INTO employee (id, firstName, lastName, login, password, occupation) 
                                        VALUES (NULL, ?, ?, ?, ?, ?)");
            $passwordHash = password_hash($_REQUEST['password'], PASSWORD_ARGON2I);

            $query->bind_param("sssss", $_REQUEST['inputFirstName'], $_REQUEST['inputLastName'], $_REQUEST['login'], $passwordHash, $_REQUEST['occupation']);

            $result = $query->execute();

            header('Location: index.php?action=employeeList');
            break;
        case 'addAnimalProcess':
            $query = $db->prepare("INSERT INTO animal (id, name, weight, dateOfBirth) 
                                    VALUES (NULL, ?, ?, ?)");

            $query->bind_param("sis", $_REQUEST['name'], $_REQUEST['weight'], $_REQUEST['dateOfBirth']);

            $result = $query->execute();

            header('Location: index.php?action=animalList');
            break;
        case 'addNoteProcess':
            $query = $db->prepare("INSERT INTO note (id,employee_Id, animal_Id, title, 
                                                    content, createDate) 
                                        VALUES (NULL,0, ?, ?,?,NULL)");
            var_dump($_REQUEST);
            $query->bind_param("iss", $_REQUEST['animalId'],$_REQUEST['inputTitle'],
                                $_REQUEST['inputContent']);
            $query->execute();
            

           // header('Location: index.php?action=aboutAnimal');
            break;
        case 'deleteEmployee':
            $query = $db->prepare("DELETE FROM employee WHERE id = ?");
            $query->bind_param("i", $_REQUEST['employee_id']);
            $query->execute();
            header('Location: index.php?action=employeeList');
            break;
        case 'deleteAnimal':
            $query = $db->prepare("DELETE FROM animal WHERE id = ?");
            $query->bind_param("i", $_REQUEST['animal_id']);
            $query->execute();
            header('Location: index.php?action=animalList');
            break;
        case 'addEmployee':
            $smarty->display('addEmployee.tpl');
            break;
        case 'addAnimal':
            $smarty->display('addAnimal.tpl');
            break;
        
        default:
            $smarty->display('index.tpl');
    }
} else {
    if (isset($_SESSION['login']))
        $smarty->display('index.tpl');
    else $smarty->display('login.tpl');
}
