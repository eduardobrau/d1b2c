<?php 

require "../bootstrap.php"; 

use core\View;
use core\Controller;
use app\componentes\Helpers;

$view = new View;
/**
 * Retorna a uri da url
 * Array
 * (
 *    [path] => /usuarios/index/
 * )
 *
*/
$controller = new Controller();
echo "<pre>"; var_dump($controller->getAction()); echo "</pre>";die;

if( $controller->isHome() ):
  //echo "<pre>"; var_dump(Uri::isHome()); echo "</pre>";
  $view->load('home');
else:
  $controlador = $controller->getController();
  $params = ( !empty(Uri::getParams()) ) ? Uri::getParams() : NULL;
  $nameSpace = "app\\controllers\\".ucfirst($controller);
  $Controller = new $nameSpace($action,$params);   
endif;


/**
 * O arquivo index.php na estrutura atual sempre será solicitado no browser
 * http://localhost/app_php/index.php?module=usuarios&action=index é ele
 * o script responsável por incluir o script bootstrap que primeiramente
 * carrega o arquivo de configuração config.php que é responsável pelas
 * configurações do sistema como variaveis de escopo global usado em todo o
 * sistema, e as funções de autoload encarregada de incluir as classes, componentes,
 * bibliotecas etc... Sem a necessidade de está dando require nos demais arquivos. 
*/