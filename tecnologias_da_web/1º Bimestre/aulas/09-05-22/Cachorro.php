<?php
require_once 'Animal.php';
class Cachorro extends Animal
{
    private $raca;
    private $cor;
    private $tamanho;
    const TEMPO_DE_VIDA = 10;

    function __construct($nome, $idade, $peso, $raca, $cor, $tamanho)
    {
        $this->setRaca($raca);
        $this->setCor($cor);
        $this->setTamanho($tamanho);
        parent::__construct($nome, $idade, $peso);
        echo "Cachorro criado na classe " . __CLASS__ . " na linha " . __LINE__ . "<br>";
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
