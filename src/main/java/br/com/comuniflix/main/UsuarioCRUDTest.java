package br.com.comuniflix.main;

import br.com.comuniflix.dao.UsuarioDAO;
import br.com.comuniflix.model.Usuario;
import br.com.comuniflix.utils.HibernateUtil;
import org.hibernate.SessionFactory;

import java.math.BigDecimal;
import java.sql.Date;


public class UsuarioCRUDTest {

    public static void main(String[] args) {
        // Chamar um SessionFactory do Hibernate
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();

        // Criar uma instância do UsuarioDAO
        UsuarioDAO usuarioDAO = new UsuarioDAO(sessionFactory);

        // Testar as operações de CRUD
        listarUsuarios(usuarioDAO);
        buscarUsuarioPorId(usuarioDAO, new BigDecimal(5));

        Usuario usuario = new Usuario();
        usuario.setNome("Sérgio Rocha");
        usuario.setCpf(new BigDecimal(101010101));
        usuario.setEmail("sergio.rocha@teste.com");
        usuario.setSenha("teste_sergio");
        usuario.setIdPlano(BigDecimal.ONE);
        usuario.setDataDeNascimento(Date.valueOf("2002-11-04"));

        salvarUsuario(usuarioDAO, usuario); // Preencha com os dados do usuário
        excluirUsuario(usuarioDAO, new BigDecimal(63));

        // Fechar o SessionFactory
        sessionFactory.close();
    }

    private static void listarUsuarios(UsuarioDAO usuarioDAO) {
        System.out.println("Lista de usuários:");
        usuarioDAO.listarUsuarios().forEach(System.out::println);
        System.out.println();
    }

    private static void buscarUsuarioPorId(UsuarioDAO usuarioDAO, BigDecimal idUsuario) {
        System.out.println("Buscando usuário por ID: " + idUsuario);
        Usuario usuario = usuarioDAO.buscarUsuarioPorId(idUsuario);
        System.out.println("Usuário encontrado: " + usuario);
        System.out.println();
    }

    private static void salvarUsuario(UsuarioDAO usuarioDAO, Usuario usuario) {
        System.out.println("Salvando usuário: " + usuario);
        usuarioDAO.salvarUsuario(usuario);
        System.out.println("Usuário salvo com sucesso.");
        System.out.println();
    }

    private static void excluirUsuario(UsuarioDAO usuarioDAO, BigDecimal idUsuario) {
        System.out.println("Excluindo usuário por ID: " + idUsuario);
        usuarioDAO.excluirUsuario(idUsuario);
        System.out.println("Usuário excluído com sucesso.");
        System.out.println();
    }
}
