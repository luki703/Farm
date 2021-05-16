<?php
require_once('./../smarty/Smarty.class.php');
session_start();
$smarty = new Smarty();
$db = new mysqli('localhost', 'root', '', 'farm');

$smarty->setTemplateDir('./../templates/admin');
$smarty->setCompileDir('./../templates_c');
$smarty->setCacheDir('./../cache');
$smarty->setConfigDir('./../configs');

//$smarty->display('index.tpl');

if(isset($_SESSION['login']))
    $smarty->assign('login', $_SESSION['login']);

if(isset($_REQUEST['action'])) {
    switch($_REQUEST['action']) {
        case 'processLogin':    
            $query = $db->prepare("SELECT * FROM admin WHERE login = ? LIMIT 1");
            $query->bind_param("s", $_REQUEST['login']);
            $query->execute();
            $result = $query->get_result();
            if($result->num_rows == 0) {
                $smarty->assign('error', "Błędny login lub hasło");
                $smarty->display('login.tpl');
                break;
            }
            $row = $result->fetch_assoc();
            if(password_verify($_REQUEST['password'], $row['password'])) {
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
            while($row = $result->fetch_assoc()) {
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
            
            while($row = $result->fetch_assoc()) {
                
                
                array_push($animals, $row);

                
            }
            $smarty->assign('animals', $animals);
            $smarty->display('animals.tpl');
        break;
        case 'generateWorkSchedule':
            $query = $db->prepare("SELECT * FROM employee");
            $query->execute();
            $result = $query->get_result();
            $employees = array();
            while($row = $result->fetch_assoc()) {
                array_push($employees, $row);
            }
            $smarty->assign('employees', $employees);
            $smarty->display('generateWorkSchedules.tpl');
           //dokończyć
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
        case 'deleteEmployee':
            $query = $db->prepare("DELETE FROM employee WHERE id = ?");
            $query->bind_param("i", $_REQUEST['employee_id']);
            $query->execute();
            header('Location: index.php?action=employeeList');
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
    if(isset($_SESSION['login']))
        $smarty->display('index.tpl');
    else $smarty->display('login.tpl');
}
?>