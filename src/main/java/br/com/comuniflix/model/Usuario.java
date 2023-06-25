package br.com.comuniflix.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "TB_USUARIO")
public class Usuario {

    @Id
    @Column(name = "ID_USUARIO")
    private BigDecimal idUsuario;

    @Column(name = "NOME")
    private String nome;

    @Column(name = "CPF")
    private BigDecimal cpf;

    @Column(name = "ID_PLANO")
    private BigDecimal idPlano;

    @Column(name = "DATA_NASCIMENTO")
    private Timestamp dataDeNascimento;

    @Column(name = "EMAIL")
    private String email;

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

    public Timestamp getDataDeNascimento() {
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

    @Column(name = "SENHA")
    private String Senha;

    @Column(name = "QTD_COMPRADA")
    private BigDecimal quantidadeComprada;
}
