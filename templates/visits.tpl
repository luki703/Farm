{include file="head.tpl"}
        
    <table class="table">
        <tr>
            <th>ID</th>
            <th>Typ</th>
            <th>Waga</th>
            <th>Data narodzin</th>
    
        </tr>
        <tr>
            <td>{$animal_Id}</td>
            <td>{$visit[0].name}</td>
            <td>{$visit[0].weight}</td>
            <td>{$visit[0].dateOfBirth}</td>
        </tr>
    </table> 
    <h1> Wizyty</h1>
    <form action="index.php" method="post">
        <input type="hidden" name="action" value="addVisitProcess">
        <input type="hidden" name="animalId" value="{$animal_Id}">
  <div class="row my-3">
    <label for="inputDate" class="col-sm-2 col-form-label">Data</label>
    <div class="col-sm-10">
      <input type="datetime-local" min="{$smarty.now|date_format:'%Y-%m-%d %H:%M'}" class="form-control" id="inputDate" name="inputDate">
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputCause" class="col-sm-2 col-form-label">Powód</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputCause" name="inputCause">
    </div>
  </div>
  <div class="d-grid gap-2 d-md-flex justify-content-md-end">   
        <button type="submit" class="btn btn-success offset-lg-10">Zapisz</button>
  </div>
  
  
</form>
    {if $visit[0].id == NULL}
        <p>Brak umówionych wizyt</p>
    {else}
        
    <table class="table my-3">
        
        <tr>
            <th>ID</th>
            <th>Data wizyty</th>
            <th colspan="2">Powód</th>
    
        </tr>
        {foreach from=$visit item=vis}
        <tr>
            
            <td>{$vis.id}</td>
            <td>{$vis.date}</td>
            <td>{$vis.cause}</td>
            <td>
                <a href="index.php?action=deleteVisit&visit_id={$vis.id}&animal_Id={$animal_Id}">
                
                <button class="btn btn-danger" type="submit">usuń</button>
            </a>
            </td>
        </tr>
        {/foreach}
    </table> 
    {/if}

{include file="foot.tpl"}