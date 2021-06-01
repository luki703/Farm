{include file="head.tpl"}
    
<div class="row">
    <a class="col-lg-9 w-25 m-3" href="index.php?action=addAnimal">
        <button class="btn btn-success w-100" type="submit">+</button>
    </a>
    <table class="table">
    <tr>
        <th>ID</th>
        <th>Typ</th>
        <th>Waga</th>
        <th>Data narodzin</th>
        <th colspan="3"></th>
        
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
            <td>
                <a href="index.php?action=aboutAnimal&animal_id={$animal.id}">
                
                <button class="btn btn-info" type="submit">info</button>
            </a>
            </td>
            <td>
                <a href="index.php?action=vetVisitsList&animal_id={$animal.id}">
                
                <button class="btn btn-info" type="submit">weterynarz</button>
            </a>
            </td>
            </td>
            
    {/foreach}
    </table>    
</div>

{include file="foot.tpl"}