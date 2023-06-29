package br.com.comuniflix.dao;

import br.com.comuniflix.model.Colaboradores;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Transaction;

public class ColaboradoresDAO {
    private final SessionFactory sessionFactory;

    public ColaboradoresDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public Colaboradores buscarColaboradorPorEmailESenha(String email, String senha) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();

        String hql = "FROM Colaboradores WHERE email = :email AND senha = :senha";
        Query<Colaboradores> query = session.createQuery(hql, Colaboradores.class);
        query.setParameter("email", email);
        query.setParameter("senha", senha);

        Colaboradores colaborador = query.uniqueResult();

        transaction.commit();
        session.close();

        return colaborador;
    }
}
