<?php
class Animal
{
    protected $nome;
    protected $idade;
    protected $peso;

    function __construct($nome, $idade, $peso)
    {
        $this->nome = $nome;
        $this->idade = $idade;
        $this->peso = $peso;
    }

    function getNome()
    {
        return $this->nome;
    }

    function getIdade()
    {
        return $this->idade;
    }

    function getPeso()
    {
        return $this->peso;
    }
}
