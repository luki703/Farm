{include file="head.tpl"}
<form action="index.php" method="post">
    <input type="hidden" name="action" value="addAnimalProcess">
    <div class="mb-3">
        <label for="name" class="form-label">Typ</label>
        <select name="name" id="name" class="form-select">
            <option selected>Open this select menu</option>
            <option value="Krowa">Krowa</option>
            <option value="Byk">Byk</option>
            <option value="Koń">Koń</option>
            <option value="Świnia">Świnia</option>
            <option value="Kura">Kura</option>
            <option value="Kogut">Kogut</option>
        </select>
    </div>
    <div class="mb-3">
      <label for="weight" class="form-label">Waga (kg)</label>
      <input type="text" name="weight" class="form-control" id="weight">
    </div>
    <div class="mb-3">
        <label for="dateOfBirth" class="form-label">Data narodzin</label>
        <input type="date" name="dateOfBirth" class="form-control" id="dateOfBirth">
      </div>
      
    
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
{include file="foot.tpl"}