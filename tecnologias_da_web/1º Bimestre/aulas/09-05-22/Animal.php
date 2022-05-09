<?php
class Animal
{
    protected $nome;
    protected $idade;
    protected $peso;
    const CASA = "Rua";

    function __construct($nome, $idade, $peso)
    {
        $this->setNome($nome);
        $this->setIdade($idade);
        $this->setPeso($peso);
        echo "Animal criado na classe " . __CLASS__ . "<br>";
    }

    function getNome()
    {
        echo "Nome do animal retornado de " . __FUNCTION__ . "<br>";
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

    function setNome($nome)
    {
        $this->nome = $nome;
    }

    function setIdade($idade)
    {
        $this->idade = $idade;
    }

    function setPeso($peso)
    {
        $this->peso = $peso;
    }
}
