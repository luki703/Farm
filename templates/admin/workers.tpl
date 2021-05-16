{include file="head.tpl"}
    
<div class="row">
    <a class="col-lg-9" href="index.php?action=addWorker">
        <button class="btn btn-primary  m-3 w-25" type="submit">dodaj nowego pracownika</button>
    </a>
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Stanowisko</th>
        <th></th>
    </tr>
    {foreach from=$workers item=worker}
        <tr>
            <td>{$worker.id}</td>
            <td>{$worker.firstName}</td>
            <td>{$worker.lastName}</td>
            <td>{$worker.occupation}</td>
            <td>
            <a href="index.php?action=deleteWorker&worker_id={$worker.id}">
                
                <button class="btn btn-danger" type="submit">usuń</button>
            </a>
            </td>
        </tr>
        
    {/foreach}
    
        
    
    </table>    
</div>

{include file="foot.tpl"}