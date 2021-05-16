{include file="head.tpl"}
    
<div class="row">
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Data narodzin</th>
        
    </tr>
    {foreach from=$animals item=animal}
        <tr>
            <td>{$animal.id}</td>
            <td>{$animal.name}</td>
            <td>{$animal.weight}</td>
            <td>{$animal.dateOfBirth}</td>
           <!-- <td>{$smarty.now|date_format:"%Y"}</td>-->
            
    {/foreach}
    </table>    
</div>

{include file="foot.tpl"}