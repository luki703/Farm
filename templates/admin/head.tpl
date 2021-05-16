<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" 
            rel="stylesheet"
            integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" 
            crossorigin="anonymous">

    <title>Panel zarządzania</title>

</head>

<body>
    <div class="container">

        <nav class="navbar w-100 navbar-expand-lg navbar-dark bg-primary ">
            <div class="container-fluid">
              
              <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index.php">Strona główna</a>
                  </li>
                  {if isset($login)}
                <li class="nav-item">
                    <a class="nav-link" href="index.php?action=workerList">Pracownicy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?action=animalList">Zwierzęta hodowlane</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?action=generateWorkSchedule">Generuj grafiki</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Witaj {$login}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.php?action=logout">Wyloguj</a>
                </li>
                {else}

                {/if}
            </ul>
            </div>
        </div>
        </nav>
    

