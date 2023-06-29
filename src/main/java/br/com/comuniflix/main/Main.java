package br.com.comuniflix.main;

import br.com.comuniflix.controllers.Login;
import spark.*;

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

        // Configurar a porta do servidor
        Spark.port(1433);

        // Configurar a rota para servir os arquivos estáticos
        Spark.staticFiles.location("/public");

        // Configurar a rota para a classe Login
        Spark.post("/login", (request, response) -> {
            // Obter os parâmetros da requisição
            String email = request.queryParams("email");
            String senha = request.queryParams("senha");

            // Criar uma instância da classe Login
            Login login = new Login();

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
