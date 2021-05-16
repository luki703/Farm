{include file="head.tpl"}
    
<div class="row">
    <a class="col-lg-9" href="index.php?action=addEmployee">
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
    {foreach from=$employees item=employee}
        <tr>
            <td>{$employee.id}</td>
            <td>{$employee.firstName}</td>
            <td>{$employee.lastName}</td>
            <td>{$employee.occupation}</td>
            <td>
            <a href="index.php?action=deleteEmployee&employee_id={$employee.id}">
                
                <button class="btn btn-danger" type="submit">usuń</button>
            </a>
            </td>
        </tr>
        
    {/foreach}
    
        
    
    </table>    
</div>

{include file="foot.tpl"}