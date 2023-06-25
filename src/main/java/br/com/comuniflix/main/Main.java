package br.com.comuniflix.main;

import br.com.comuniflix.model.Plano;
import br.com.comuniflix.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        Query<Plano> query = session.createNativeQuery("SELECT * FROM TB_PLANO", Plano.class);

        List<Plano> results = query.getResultList();
        for (Plano plano : results) {
            System.out.println("ID: " + plano.getIdPlano());
            System.out.println("Descrição: " + plano.getDescricaoPlano());
            System.out.println("Valor Plano: " + plano.getValorPlano());
            System.out.println("\n");
            // Acesse os outros atributos do plano conforme necessário
        }

        session.getTransaction().commit();
        session.close();
    }
}
