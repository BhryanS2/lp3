<?php
class Animal
{
    private $Nome;
    private $Cor;
    private $Idade;

    public function setNome($Nome)
    {
        $this->Nome = $Nome;
    }
    public function getNome()
    {
        return $this->Nome;
    }
    public function setCor($Cor)
    {
        $this->Cor = $Cor;
    }
    public function getCor()
    {
        return $this->Cor;
    }
    public function setIdade($Idade)
    {
        $this->Idade = $Idade;
    }
    public function getIdade()
    {
        return $this->Idade;
    }
}
