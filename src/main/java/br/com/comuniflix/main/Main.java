package br.com.comuniflix.main;

import br.com.comuniflix.model.Plano;
import br.com.comuniflix.model.Usuario;
import br.com.comuniflix.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();

        Query<Usuario> query = session.createNativeQuery("SELECT * FROM TB_USUARIO", Usuario.class);

        List<Usuario> results = query.getResultList();
        for (Usuario usuario : results) {
            System.out.println("ID: " + usuario.getIdUsuario());
            System.out.println("Nome: " + usuario.getNome());
            System.out.println("Email: " + usuario.getEmail());
            System.out.println("\n");
            // Acesse os outros atributos do plano conforme necessário
        }

        session.getTransaction().commit();
        session.close();
    }
}
