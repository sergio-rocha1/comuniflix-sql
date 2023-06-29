package br.com.comuniflix.controllers;

import br.com.comuniflix.dao.ColaboradoresDAO;
import br.com.comuniflix.model.Colaboradores;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import spark.*;

public class Login {

    private final SessionFactory sessionFactory;

    public Login() {
        // Configurar a sessão do Hibernate
        Configuration configuration = new Configuration().configure();
        sessionFactory = configuration.buildSessionFactory();
    }

    public boolean verificarCredenciais(String email, String senha) {
        // Criar uma nova sessão do Hibernate
        Session session = sessionFactory.openSession();

        // Iniciar uma transação
        Transaction transaction = session.beginTransaction();

        // Criar uma instância do DAO de colaboradores
        ColaboradoresDAO colaboradoresDAO = new ColaboradoresDAO(sessionFactory);

        // Buscar o colaborador por email e senha usando o DAO
        Colaboradores colaborador = colaboradoresDAO.buscarColaboradorPorEmailESenha(email, senha);

        // Commitar a transação e fechar a sessão
        transaction.commit();
        session.close();

        // Verificar se o colaborador foi encontrado
        return colaborador != null;
    }

    public static void main(String[] args) {
        // Criar uma instância da classe Login
        Login login = new Login();

        // Realizar a chamada ao backend para verificar as credenciais
        Spark.port(1433);

        // Configurar a rota para a classe Login
        Spark.post("/login", (request, response) -> {
            // Obter os parâmetros da requisição
            String email = request.queryParams("email");
            String senha = request.queryParams("senha");

            // Verificar as credenciais
            boolean loginValido = login.verificarCredenciais(email, senha);

            // Retornar a resposta como JSON
            response.type("application/json");
            if (loginValido) {
                return "{\"success\": true}";
            } else {
                return "{\"success\": false}";
            }
        });
    }
}
