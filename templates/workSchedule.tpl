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
            <th></th>
            <th></th>
            <th colspan="4">Godziny</th>
            
        </tr>
        <tr>
            <th>Dzień</th>
            <th>Status</th>
            <th>Od</th>
            <th colspan="3">Do</th>
            
        </tr>
        {foreach from=$workschedules item=workschedule}
        <tr>
            <td>{$workschedule.shiftStart}</td>
            {if $workschedule.status==0}
                <td>-</td>
                {elseif $workschedule.status==1}
                  <td>wolne</td>  
            {/if}
            
            <td>{$workschedule.shiftTimeStart}</td>
            <td>{$workschedule.shiftTimeEnd}</td>
            <td><!--modyfikacja-->
            {if {$workschedule.status}==0}
            <a href="index.php?action=changeStatusWorkSchedule&workSchedule_id={$workschedule.id}">
                <button class="btn btn-primary" type="submit">Weź wolne</button>
            </a>
            {else}
                <a href="index.php?action=changeStatusWorkSchedule&workSchedule_id={$workschedule.id}">
                <button class="btn btn-danger" type="submit">Cofnij wolne</button>
            </a>
            {/if}
            
            </td>
            
            <!--modyfikacja-->
        </tr>
        
        {/foreach}
    </table>  
</div>

{include file="foot.tpl"}