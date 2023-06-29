package br.com.comuniflix.model;


import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;

@Entity
@Table(name = "TB_USUARIO")
public class Usuario {

    @Id
    @Column(name = "ID_USUARIO")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private BigDecimal idUsuario;

    @Column(name = "NOME")
    private String nome;

    @Column(name = "CPF")
    private BigDecimal cpf;

    @Column(name = "ID_PLANO")
    private BigDecimal idPlano;

    @Column(name = "DATA_NASCIMENTO")
    private Date dataDeNascimento;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "SENHA")
    private String Senha;

    @Column(name = "QTD_COMPRADA")
    private BigDecimal quantidadeComprada = BigDecimal.ZERO;

    public BigDecimal getIdUsuario() {
        return idUsuario;
    }

    public String getNome() {
        return nome;
    }

    public BigDecimal getCpf() {
        return cpf;
    }

    public BigDecimal getIdPlano() {
        return idPlano;
    }

    public Date getDataDeNascimento() {
        return dataDeNascimento;
    }

    public String getEmail() {
        return email;
    }

    public String getSenha() {
        return Senha;
    }

    public BigDecimal getQuantidadeComprada() {
        return quantidadeComprada;
    }

    public void setIdUsuario(BigDecimal idUsuario) {
        this.idUsuario = idUsuario;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCpf(BigDecimal cpf) {
        this.cpf = cpf;
    }

    public void setIdPlano(BigDecimal idPlano) {
        this.idPlano = idPlano;
    }

    public void setDataDeNascimento(Date dataDeNascimento) {
        this.dataDeNascimento = dataDeNascimento;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSenha(String senha) {
        Senha = senha;
    }

    public void setQuantidadeComprada(BigDecimal quantidadeComprada) {
        this.quantidadeComprada = quantidadeComprada;
    }


}
