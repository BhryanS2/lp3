<?php
abstract class Pessoa
{
    private $Nome;
    private $Endereco;
    private $Telefone;
    private $Email;

    public function setNome($Nome)
    {
        $this->Nome = $Nome;
    }
    public function getNome()
    {
        return $this->Nome;
    }
    public function setEndereco($Endereco)
    {
        $this->Endereco = $Endereco;
    }
    public function getEndereco()
    {
        return $this->Endereco;
    }
    public function setTelefone($Telefone)
    {
        $this->Telefone = $Telefone;
    }
    public function getTelefone()
    {
        return $this->Telefone;
    }
    public function setEmail($Email)
    {
        $this->Email = $Email;
    }
    public function getEmail()
    {
        return $this->Email;
    }
}
