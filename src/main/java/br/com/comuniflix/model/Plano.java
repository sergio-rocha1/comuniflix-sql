package br.com.comuniflix.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "TB_PLANO")
public class Plano {
    @Id
    @Column(name = "ID_PLANO")
    private Long idPlano;

    @Column(name = "DESC_PLANO")
    private String descricaoPlano;

    @Column(name = "VALOR_PLANO")
    private Long valorPlano;

    @Column(name = "ID_MOD_PLANO")
    private Long idModoPlano;

    public Long getIdPlano() {
        return idPlano;
    }

    public void setIdPlano(Long idPlano) {
        this.idPlano = idPlano;
    }

    public String getDescricaoPlano() {
        return descricaoPlano;
    }

    public void setDescricaoPlano(String descricaoPlano) {
        this.descricaoPlano = descricaoPlano;
    }

    public Long getValorPlano() {
        return valorPlano;
    }

    public void setValorPlano(Long valorPlano) {
        this.valorPlano = valorPlano;
    }

    public Long getIdModoPlano() {
        return idModoPlano;
    }

    public void setIdModoPlano(Long idModoPlano) {
        this.idModoPlano = idModoPlano;
    }
}
