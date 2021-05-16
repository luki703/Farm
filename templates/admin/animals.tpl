{include file="head.tpl"}
    
<div class="row">
    <a class="col-lg-9" href="index.php?action=addAnimal">
        <button class="btn btn-primary  m-3 w-25" type="submit">+</button>
    </a>
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Typ</th>
        <th>Waga</th>
        <th>Data narodzin</th>
        <th></th>
        
    </tr>
    {foreach from=$animals item=animal}
        <tr>
            <td>{$animal.id}</td>
            <td>{$animal.name}</td>
            <td>{$animal.weight}</td>
            <td>{$animal.dateOfBirth}</td>
            <td>
                <a href="index.php?action=deleteAnimal&animal_id={$animal.id}">
                
                <button class="btn btn-danger" type="submit">usuń</button>
            </a>
            </td>
            </td>
            
    {/foreach}
    </table>    
</div>

{include file="foot.tpl"}