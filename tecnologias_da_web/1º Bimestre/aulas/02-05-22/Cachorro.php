<?php
require_once 'Animal.php';
class Cachorro extends Animal
{
    private $raca;
    private $cor;
    private $tamanho;

    function __construct($nome, $idade, $peso)
    {
        parent::__construct($nome, $idade, $peso);
        $this->raca = "";
        $this->cor = "";
        $this->tamanho = "";
    }

    function getRaca()
    {
        return $this->raca;
    }

    function getCor()
    {
        return $this->cor;
    }

    function getTamanho()
    {
        return $this->tamanho;
    }

    function setRaca($raca)
    {
        $this->raca = $raca;
    }

    function setCor($cor)
    {
        $this->cor = $cor;
    }

    function setTamanho($tamanho)
    {
        $this->tamanho = $tamanho;
    }
}
