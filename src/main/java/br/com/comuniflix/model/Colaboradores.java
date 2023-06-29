package br.com.comuniflix.model;


import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;

@Entity
@Table(name = "TB_COLAB")
public class Colaboradores {
    @Id
    @Column(name = "ID_COLAB")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigDecimal idColab;

    @Column(name = "CPF")
    private BigDecimal cpf;

    @Column(name = "DATA_NASCIMENTO")
    private Date dataDeNascimento;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "SENHA")
    private String senha;

    @Column(name = "ID_CARGO")
    private BigDecimal cargo;

    @Column(name = "FERIAS")
    private BigDecimal ferias;

    @Column(name = "DATA_ADMISSAO")
    private Date dataDeAdmissao;

    @Column(name = "NOME")
    private String nome;

    public BigDecimal getIdColab() {
        return idColab;
    }

    public void setIdColab(BigDecimal idColab) {
        this.idColab = idColab;
    }

    public BigDecimal getCpf() {
        return cpf;
    }

    public void setCpf(BigDecimal cpf) {
        this.cpf = cpf;
    }

    public Date getDataDeNascimento() {
        return dataDeNascimento;
    }

    public void setDataDeNascimento(Date dataDeNascimento) {
        this.dataDeNascimento = dataDeNascimento;
    }

    public String getEmail() {

        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        senha = senha;
    }

    public BigDecimal getCargo() {
        return cargo;
    }

    public void setCargo(BigDecimal cargo) {
        cargo = cargo;
    }

    public BigDecimal getFerias() {
        return ferias;
    }

    public void setFerias(BigDecimal ferias) {
        ferias = ferias;
    }

    public Date getDataDeAdmissao() {
        return dataDeAdmissao;
    }

    public void setDataDeAdmissao(Date dataDeAdmissao) {
        this.dataDeAdmissao = dataDeAdmissao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}