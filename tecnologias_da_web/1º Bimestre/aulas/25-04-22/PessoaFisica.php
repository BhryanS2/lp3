<?php
require 'Pessoa.php';
class PessoaFisica extends Pessoa
{
    private $Idade;
    private $CPF;
    private $RG;
    private $DataNascimento;

    public function setIdade($Idade)
    {
        $this->Idade = $Idade;
    }
    public function getIdade()
    {
        return $this->Idade;
    }
    public function setCPF($CPF)
    {
        $this->CPF = $CPF;
    }
    public function getCPF()
    {
        return $this->CPF;
    }
    public function setRG($RG)
    {
        $this->RG = $RG;
    }
    public function getRG()
    {
        return $this->RG;
    }
    public function setDataNascimento($DataNascimento)
    {
        $this->DataNascimento = $DataNascimento;
    }
    public function getDataNascimento()
    {
        return $this->DataNascimento;
    }
}
