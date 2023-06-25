package br.com.comuniflix.factory;
import java.sql.Connection;
import java.sql.DriverManager;

// Estou utilizando o seguinte vídeo para fazer a integração, parei no terceiro vídeo.
//https://www.youtube.com/watch?v=-2Qgpe7T5tc&t


// Classe responsável para conexão no Banco de Dados
public class ConnectionFactory {

    // Logins de Usuário no Banco de Dados (deve alterar para cada banco de dados)
    private static final String USERNAME= "acesso-banco";

    private static final String PASSWORD = "123";

    private static final String DATABASE_URL = "jdbc:sqlserver://localhost:1433;DESKTOP-HE81TLJ\\SQLEXPRESS=COMUNIFLIX";

    /* Cria a conexão com o Banco (Necessário o Download de SQL Server JDBC)*/
    public static Connection createConnectionToSQLServer() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        Connection connection = DriverManager.getConnection(DATABASE_URL, USERNAME, PASSWORD);

        return connection;
    }
    public static void main(String[] args) throws Exception {

        /* Recupera uma conexão */
        Connection con = createConnectionToSQLServer();

        /* Testa a conexão */
        if (con != null) {
            System.out.println("Conexão Estabelecida");
            con.close();
        }
    }
}

