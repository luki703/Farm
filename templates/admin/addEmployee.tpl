{include file="head.tpl"}
<form action="index.php" method="post">
    <input type="hidden" name="action" value="addEmployeeProcess">
    <div class="mb-3">
      <label for="inputFirstName" class="form-label">Imię</label>
      <input type="text" name="inputFirstName" class="form-control" id="inputFirstName">
    </div>
    <div class="mb-3">
      <label for="inputLastName" class="form-label">Nazwisko</label>
      <input type="text" name="inputLastName" class="form-control" id="inputLastName">
    </div>
    <div class="mb-3">
        <label for="login" class="form-label">Login</label>
        <input type="text" name="login" class="form-control" id="login">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Hasło</label>
        <input type="password" name="password" class="form-control" id="password">
      </div>
      <div class="mb-3">
        <label for="occupation" class="form-label">Stanowisko</label>
        <input type="text" name="occupation" class="form-control" id="occupation">
      </div>
    
    <button type="submit" class="btn btn-success">Dodaj</button>
  </form>
{include file="foot.tpl"}