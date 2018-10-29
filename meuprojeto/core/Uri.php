<?php

namespace core;

class Uri{

  private $uri;
  private $controller;
  private $action;
  private $params;

  /**
   * Ao inicializar esta classe já inicia a propriedade $uri
   * pois não faz sentido iniciar este objeto sem ter a variavel
   * super global $_SERVER['REQUEST_URI'] iniciada 
   */
  public function __construct(){
    $this->getUri();
    $this->iniProps();
  }

  /**
   * Sempre vai retornar um array com o path e caso tenha parametros
   * retorna esses como uma query string da url digitada
   * exemplo: http://encontraabc.localhost/app/php?id=1232dsd&ul=idfu
   * Array
   * (
   *    [path] => /app/php
   *    [query] => id=1232dsd&ul=idfu
   * )
   * 
  */
  private function getUri(){
    return $this->uri = parse_url($_SERVER['REQUEST_URI']);
  }

  private function retPath(){

    if(!empty($this->uri['path'])):
      /***
       * Retorna parte do path, elimando a primeira /
       * [path] => /app/php
       * retorna app/php
       */
      $path = substr($this->uri['path'], 1);
      /**
       * Explode toda ocorrencia de / e para cada
       * ocorrência um novo indice do array
       * (
       *    [0] => app
       *    [1] => php
       * )
       */
      return $path = explode('/',$path);
      
    endif;
    
  }

  private function iniProps(){
    
    $path = $this->retPath();   
    $lenghtPath = count($path);
    
    switch ($lenghtPath) {
      case ($lenghtPath > 2):
        # code...
      break;
      /**
       *  Caso seja igual a 2 sei que se trata do controller
       *  e action.
       */
      case ($lenghtPath == 2):
        $this->action = strtolower($path[1]);
        $this->controller = ucfirst(strtolower($path[0]));
      break;
      case ($lenghtPath == 1):
        $this->controller = ucfirst(strtolower($path[0]));
      break;
      default:
        $this->controller = NULL;
        $this->action = NULL;
      break;
    }
    
  }

  public function retController(){
    return $this->controller;
  }

  public function retAction(){
    return $this->action;
  }

  /**
   * parse_str retorna uma array dos parametros passados
   * via query string da url digitada
   * Array
   *  (
   *   [id] => 1232dsd
   *   [ul] => idfu
   * )
   */
  public function getParams(){
    if( !empty($this->uri['query']) ):
      parse_str($this->uri['query'], $this->params);
      return $this->params;
    endif;
  }

  public function isHomePage(){
    return ( !empty($this->uri) and $this->uri['path'] === '/' ) ? true : false;
  }


}