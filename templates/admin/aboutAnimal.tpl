{include file="head.tpl"}



<form action="index.php" method="post">
    <table class="table">
        <tr>
            <th>ID</th>
            <th>Typ</th>
            <th>Waga</th>
            <th>Data narodzin</th>
    
        </tr>
        <tr>
            <td>{$animal.id}</td>
            <td>{$animal.name}</td>
            <td>{$animal.weight}</td>
            <td>{$animal.dateOfBirth}</td>
        </tr>
    </table>   
    <input type="hidden" name="action" value="addNoteProcess">
    <input type="hidden" name="animalId" value="{$animal.id}">
  <div class="row my-3">
    <label for="inputTitle" class="col-sm-2 col-form-label">Tytuł</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputTitle" name="inputTitle">
    </div>
  </div>
  <div class="row mb-3">
    <label for="inputContent" class="col-sm-2 col-form-label">Treść</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputContent" name="inputContent">
    </div>
  </div>
  <div class="d-grid gap-2 d-md-flex justify-content-md-end">   
        <button type="submit" class="btn btn-primary offset-lg-10">Zapisz</button>
  </div>
  
  
</form>

{if $notes != NULL}

<table class="table">
    <tr>
        <th>Tytuł</th>
        <th>Autor</th>
        <th>Data</th>

    </tr>
    {foreach from=$notes item=note}
    <tr>
        <td>{$note.title}</td>
        {if $note.employee_Id ==0}
            <td>ADMIN</td>
            
            {else}
                <td>{$note.firstName} {$note.lastName}</td>
        {/if}
        
        <td>{$note.createDate}</td>
    </tr>
    <tr>
       <td colspan="3"> {$note.content}</td>
    </tr>
    <tr>
        <td class="text-center" colspan="3">
            <a href="index.php?action=deleteNote&note_id={$note.id}">
                <button class="btn btn-danger" type="submit">usuń</button>
            </a>
        </td>
    </tr>
    
    {/foreach}
    
</table>
{else}
<h4>Brak dodatkowych informacji</h4>
{/if}

{include file="foot.tpl"}