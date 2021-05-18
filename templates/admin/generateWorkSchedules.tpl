{include file="head.tpl"}
    
        <main class="row">
            <div class="col">
                <form action="index.php" method="post">
    <input type="hidden" name="action" value="generateScheduleProcess">
    <div class="mb-3">
        <label for="employee" class="form-label">Pracownik</label>
        <select name="employee" id="employee" class="form-select">
            <option selected>Wybierz pracownika</option>
            {foreach from=$employees item=employee}
              <option value="{$employee.id}"> {$employee.firstName} {$employee.lastName} </option>
            {/foreach}
            
        </select>
    </div>
    
    <div class="mb-3">
                {$smarty.now|date_format:'%Y-%m-%d'}
              <label class="form-label" for="shiftStart">Początek zakresu zmiany</label>
              <input class="form-control" type="date" name="shiftStart" id="shiftStart" min="{$smarty.now|date_format:'%Y-%m-%d'}">
            </div>
          <div class="mb-3">
            <label class="form-label" for="shiftEnd">Koniec zakresu zmiany</label>
              <input class="form-control" type="date" name="shiftEnd" id="shiftEnd" min="{$smarty.now|date_format:'%Y-%m-%d'}"> 
        </div>
        <div class="mb-3">
            <label class="form-label" for="shiftTimeStart">Godzina rozpoczęcia zmian</label>
              <input class="form-control" type="time"  name="shiftTimeStart" id="shiftTimeStart"> 
        </div>
        <div class="mb-3">
            <label class="form-label" for="shiftTimeEnd">Godzina zakończenia zmiany</label>
              <input class="form-control" type="time"  name="shiftTimeEnd" id="shiftTimeEnd">  
        </div>
    
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
            </div>
        </main>

{include file="foot.tpl"}