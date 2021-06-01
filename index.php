<?php
require_once('./smarty/Smarty.class.php');
session_start();
$smarty = new Smarty();
$db = new mysqli('localhost', 'root', '', 'farm');
$animalId;

$smarty->setTemplateDir('./templates');
$smarty->setCompileDir('./templates_c');
$smarty->setCacheDir('./cache');
$smarty->setConfigDir('./configs');

if (isset($_SESSION['login']))
    $smarty->assign('firstName', $_SESSION['firstName']);   

if (isset($_REQUEST['action'])) {
    switch ($_REQUEST['action']) {
        case 'processLogin':
            $query = $db->prepare("SELECT * FROM employee WHERE login = ? LIMIT 1");
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
                $query = $db->prepare("SELECT * FROM employee WHERE id=?");
                $query->bind_param("i", $row['id']);
                $query->execute();
                $result = $query->get_result();
                $row = $result->fetch_assoc();
                $_SESSION['firstName'] = $row['firstName'];
                $_SESSION['lastName'] = $row['lastName'];
                $_SESSION['occupation'] = $row['occupation'];
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
        case 'aboutMe':
            var_dump($_SESSION);
            $query = $db->prepare("SELECT * FROM employee WHERE id=?");
            $query->bind_param("i", $_SESSION["userID"]);
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
        case 'deleteNote':
            $query = $db->prepare("SELECT animal_Id FROM note WHERE id =?");
            $query->bind_param("i", $_REQUEST['note_id']);
            $query->execute();
            $result = $query->get_result();
            $row = $result->fetch_assoc();
            $animal_Id = implode("",$row);
            var_dump($animal_Id);

            $query = $db->prepare("DELETE FROM note WHERE id = ?");
            $query->bind_param("i", $_REQUEST['note_id']);
            $query->execute();
            
            header('Location: index.php?action=aboutAnimal&animal_id='.$animal_Id);
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
            $smarty->assign('UserID', $_SESSION['userID']);
            $smarty->assign('notes', $notes);
            $smarty->display('aboutAnimal.tpl');
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
            $query = $db->prepare("SELECT workschedule.id, workschedule.shiftStart,
                                          workschedule.shiftTimeStart, workschedule.shiftTimeEnd,
                                          workschedule.status, workschedule.employeeId
                                   FROM workschedule
                                   LEFT JOIN employee 
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
                                        VALUES (NULL,?, ?, ?,?,NULL)");

            $query->bind_param(
                "iiss",
                $_SESSION['userID'],
                $_REQUEST['animalId'],
                $_REQUEST['inputTitle'],
                $_REQUEST['inputContent']
            );
            $query->execute();
            header('Location: index.php?action=aboutAnimal&animal_id='.$_REQUEST['animalId']);


            break;
        case 'addVisitProcess':
            $query = $db->prepare("INSERT INTO vetvisit (id, animal_Id, date, cause) 
            VALUES (NULL,?, FROM_UNIXTIME(?), ?)");
            
            $day = strtotime($_REQUEST['inputDate']);
            //echo $_REQUEST['inputCause'];
            //var_dump($day);
            $query->bind_param("iis", $_REQUEST['animalId'],$day,
                             $_REQUEST['inputCause'] );
                             //var_dump($_REQUEST);
            $query->execute();             
            header("Location: index.php?action=vetVisitsList&animal_id=".$_REQUEST['animalId']);
            
            
        break;
        
        case 'deleteAnimal':
            $query = $db->prepare("DELETE FROM animal WHERE id = ?");
            $query->bind_param("i", $_REQUEST['animal_id']);
            $query->execute();
            header('Location: index.php?action=animalList');
            break;
        
        case 'changeStatusWorkSchedule':
            $query = $db->prepare("SELECT employeeId, status FROM workschedule WHERE id= ?");
            $query->bind_param("i", $_REQUEST['workSchedule_id'] );
            $query->execute();
            $result = $query->get_result();
            $row = $result->fetch_assoc();
            $chain = implode(",",$row);
            //echo($chain);
            $employee_Id = substr($chain, 0, 2);
            $status = substr($chain, -1);
            if ($status == 1) {
                $status = 0;
            }
            else {
                $status =1;
            }
            //echo($status);
            
            $query = $db->prepare("UPDATE workschedule SET status = ? WHERE id = ?");
            $query->bind_param("ii",$status, $_REQUEST['workSchedule_id'] );
            
            $query->execute();
           // var_dump($query);
            
            header('Location: index.php?action=showWorkSchedule&employee_id='.$employee_Id);
           
            break;

        
        case 'vetVisitsList':
            $query = $db->prepare("SELECT vet.id, vet.date, vet.cause,
                                        vet.animal_Id, a.name, a.dateOfBirth, a.weight
                                    FROM vetvisit AS vet
                                    RIGHT JOIN animal AS a ON
                                    vet.animal_Id = a.id
                                    WHERE a.id=?");
            $query->bind_param("i", $_REQUEST['animal_id']);
            $query->execute();

            $result = $query->get_result();
            $visits = array();

            while ($row = $result->fetch_assoc()) {

                array_push($visits, $row);
            }
            $smarty->assign('animal_Id', $_REQUEST['animal_id']); // if there is no visit
                                                                  // vet.animal_Id is null
                $smarty->assign('visit', $visits);
                $smarty->display('visits.tpl');
            break;
        case 'deleteVisit':
            $query = $db->prepare("DELETE FROM vetvisit WHERE id = ?");
            $query->bind_param("i", $_REQUEST['visit_id']);
            $query->execute();
            
            header("Location: index.php?action=vetVisitsList&animal_id=".$_REQUEST['animal_Id']);
            
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
