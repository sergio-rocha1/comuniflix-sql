//package br.com.comuniflix.dao;
//
//import br.com.comuniflix.factory.ConnectionFactory;
//import br.com.comuniflix.model.TB_TrilhaSonora;
//import com.microsoft.sqlserver.jdbc.ISQLServerPreparedStatement;
//
//import java.sql.Connection;
//import java.sql.SQLException;
//
//
//public class TrilhaSonoraDAO {
//
//    //
//    public void save(TB_TrilhaSonora Trilha) throws SQLException {
//
//        //Passando os parâmetros para inserção na data base, contém o nome da tabela e os valores
//        String sql = "INSERT INTO TrilhaSonoras(ID, ID_SERIE, DURACAO, NOME) VALUES(?, ?, ?, ?)";
//
//        Connection conn = null;
//
//        // Prepara uma estrutura para executar o Java com SQL Server
//        ISQLServerPreparedStatement pstm = null;
//
//
//        try {
//            // Cria conexão com o Banco de Dados
//            conn = ConnectionFactory.createConnectionToSQLServer();
//
//            //Cria e prepara a Query do Banco
//            pstm = (ISQLServerPreparedStatement) conn.prepareStatement(sql);
//
//            // Passa os parâmetros para inserção no banco, utilizando Getters
//            pstm.setInt(4, Trilha.getID());
//            pstm.setInt(4, Trilha.getID_SERIE());
//            pstm.setInt(2, Trilha.getDURACAO());
//            pstm.setString(2, Trilha.getNOME());
//
//            // Executa a Query
//            pstm.execute();
//            System.out.println("Executado com sucesso");
//        }
//
//        // Em caso de Exception, printa o Erro no Catch
//        catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        finally {
//            try {
//
//                // Fecha as conexöes com o PreparedStatement
//                if (pstm != null) {
//                    pstm.close();
//                }
//
//                if (conn != null) {
//                    conn.close();
//                }
//
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//}