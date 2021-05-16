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
        case 'workerList':
            $query = $db->prepare("SELECT * FROM worker");
            $query->execute();
            $result = $query->get_result();
            $workers = array();
            while($row = $result->fetch_assoc()) {
                array_push($workers, $row);
            }
            $smarty->assign('workers', $workers);
            $smarty->display('workers.tpl');
        break;
        case 'animalList':
            $query = $db->prepare("SELECT * FROM animal");
            $query->execute();
            $result = $query->get_result();
            $animals = array();
            
            while($row = $result->fetch_assoc()) {
                
                array_push($animals, $row);
                var_dump($row);
            }
            $smarty->assign('animals', $animals);
            $smarty->display('animals.tpl');
        break;
        case 'generateWorkSchedule':
            $query = $db->prepare("SELECT * FROM worker");
            $query->execute();
            $result = $query->get_result();
            $workers = array();
            while($row = $result->fetch_assoc()) {
                array_push($workers, $row);
            }
            $smarty->assign('workers', $workers);
            $smarty->display('generateWorkSchedules.tpl');
           //dokończyć
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