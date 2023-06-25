package br.com.comuniflix.dao;

import br.com.comuniflix.model.Usuario;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import java.math.BigDecimal;
import java.util.List;

public class UsuarioDAO {

    private final SessionFactory sessionFactory;

    public UsuarioDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Usuario> listarUsuarios() {
        Session session = sessionFactory.openSession();
        List<Usuario> usuarios = session.createQuery("FROM Usuario", Usuario.class).list();
        session.close();
        return usuarios;
    }

    public Usuario buscarUsuarioPorId(BigDecimal idUsuario) {
        Session session = sessionFactory.openSession();
        Usuario usuario = session.get(Usuario.class, idUsuario);
        session.close();
        return usuario;
    }

    public void salvarUsuario(Usuario usuario) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.saveOrUpdate(usuario);
        transaction.commit();
        session.close();
    }

    public void excluirUsuario(BigDecimal idUsuario) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        Usuario usuario = session.get(Usuario.class, idUsuario);
        if (usuario != null) {
            session.delete(usuario);
        }
        transaction.commit();
        session.close();
    }
}
