{include file="head.tpl"}
    
<div class="row">
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Imię</th>
        <th>Nazwisko</th>
    </tr>
    {foreach from=$workers item=worker}
        <tr>
            <td>{$worker.id}</td>
            <td>{$worker.firstName}</td>
            <td>{$worker.lastName}</td>
    {/foreach}
    </table>    
</div>

{include file="foot.tpl"}