{include file="head.tpl"}
    
<div class="row">
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Stanowisko</th>
        
    </tr>
    
        <tr>
            <td>{$employee.id}</td>
            <td>{$employee.firstName}</td>
            <td>{$employee.lastName}</td>
            <td>{$employee.occupation}</td>
        </tr>
    
    </table>  
    <table class="table">
        <tr>
            <th>Dni</th>
            <th></th>
            <th>Godziny</th>
            <th></th>
        </tr>
        <tr>
            <th>Od</th>
            <th>Do</th>
            <th>Od</th>
            <th>Do</th>
        </tr>
        {foreach from=$workschedules item=workschedule}
        <tr>
            <td>{$workschedule.shiftStart}</td>
            <td>{$workschedule.shiftEnd}</td>
            <td>{$workschedule.shiftTimeStart}</td>
            <td>{$workschedule.shiftTimeEnd}</td>
            
        </tr>
        
        {/foreach}
    </table>  
</div>

{include file="foot.tpl"}