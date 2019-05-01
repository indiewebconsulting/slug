<?php
/**
 * FILE: index.php
 * 
 * Include and execute SLUG PHP API, 
 * then call exec() to execute the routed command,
 * which outputs the return of the command as JSON 
 * 
 */

include 'slug.php';

$trail = new \BiStorm\SLUG\Slug('slug.json', 'bistorm', array(), false);

$trail->exec();

exit();

?>