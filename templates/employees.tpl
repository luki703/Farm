{include file="head.tpl"}
    
<div class="row">
    
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Stanowisko</th>
        <th></th>
        <th></th>
    </tr>
    {foreach from=$employees item=employee}
        <tr>
            <td>{$employee.id}</td>
            <td>{$employee.firstName}</td>
            <td>{$employee.lastName}</td>
            <td>{$employee.occupation}</td>
            
            <td>
            <a href="index.php?action=showWorkSchedule&employee_id={$employee.id}">
                
                <button class="btn btn-info" type="submit">zobacz grafik</button>
            </a>
            </td>
        </tr>
        
    {/foreach}
    </table>    
</div>

{include file="foot.tpl"}