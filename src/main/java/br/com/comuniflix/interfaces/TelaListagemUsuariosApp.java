package br.com.comuniflix.interfaces;

import br.com.comuniflix.dao.UsuarioDAO;
import br.com.comuniflix.model.Usuario;
import br.com.comuniflix.utils.DateUtils;
import br.com.comuniflix.utils.HibernateUtils;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.math.BigDecimal;
import java.util.List;

public class TelaListagemUsuariosApp extends JFrame {

    private JTable tabela;
    private DefaultTableModel modeloTabela;
    private UsuarioDAO usuarioDAO = new UsuarioDAO(HibernateUtils.getSessionFactory());

    public TelaListagemUsuariosApp() {
        setTitle("Listagem de Usuários");
        setSize(800, 400);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        // Define o fundo preto
        getContentPane().setBackground(Color.BLACK);
        getContentPane().setLayout(new BorderLayout());

        modeloTabela = new DefaultTableModel();
        modeloTabela.addColumn("ID");
        modeloTabela.addColumn("Nome");
        modeloTabela.addColumn("CPF");
        modeloTabela.addColumn("ID do Plano");
        modeloTabela.addColumn("Data de Nascimento");
        modeloTabela.addColumn("Email");
        modeloTabela.addColumn("Senha");

        tabela = new JTable(modeloTabela);
        tabela.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);

        JScrollPane painelRolagem = new JScrollPane(tabela);

        JPanel painelBotoes = new JPanel();
        painelBotoes.setLayout(new FlowLayout());

        JButton botaoRemoverUsuario = new JButton("Remover Usuário");
        botaoRemoverUsuario.addActionListener(e -> {
            int linhaSelecionada = tabela.getSelectedRow();
            if (linhaSelecionada != -1) {
                Usuario usuarioSelecionado = getUsuarioDaLinha(linhaSelecionada);
                usuarioDAO.excluirUsuario(usuarioSelecionado.getIdUsuario());
                modeloTabela.removeRow(linhaSelecionada);

                String mensagem = "Usuário '" + usuarioSelecionado.getNome() + "' foi excluído com sucesso.";
                JOptionPane.showMessageDialog(null, mensagem);
            } else {
                JOptionPane.showMessageDialog(null, "Você deve selecionar um usuário para exclusão!");
            }
        });
        painelBotoes.add(botaoRemoverUsuario);

        JButton botaoEditarUsuario = new JButton("Editar Usuário");
        botaoEditarUsuario.addActionListener(e -> {
            int linhaSelecionada = tabela.getSelectedRow();
            if (linhaSelecionada != -1) {
                Usuario usuarioSelecionado = getUsuarioDaLinha(linhaSelecionada);
                EditarDado editarDado = new EditarDado(usuarioSelecionado, this);
                editarDado.setVisible(true);
            } else {
                JOptionPane.showMessageDialog(null, "Você deve selecionar um usuário para edição!");
            }
        });
        painelBotoes.add(botaoEditarUsuario);

        JButton botaoVoltar = new JButton("Voltar");
        botaoVoltar.addActionListener(e -> {
            dispose();
        });
        painelBotoes.add(botaoVoltar);

        getContentPane().add(painelRolagem, BorderLayout.CENTER);
        getContentPane().add(painelBotoes, BorderLayout.SOUTH);

        atualizarTabela();

        // Adiciona o letreiro "COMUNIFLIX" em vermelho centralizado na parte superior da janela
        JLabel rotuloTitulo = new JLabel("COMUNIFLIX");
        rotuloTitulo.setForeground(Color.RED);
        rotuloTitulo.setFont(new Font("Arial", Font.BOLD, 24));
        rotuloTitulo.setHorizontalAlignment(SwingConstants.CENTER);
        getContentPane().add(rotuloTitulo, BorderLayout.NORTH);
    }

    private Usuario getUsuarioDaLinha(int linha) {
        int id = Integer.parseInt(modeloTabela.getValueAt(linha, 0).toString());
        return usuarioDAO.buscarUsuarioPorId(BigDecimal.valueOf(id));
    }

    public void atualizarTabela() {
        modeloTabela.setRowCount(0);

        List<Usuario> listaUsuarios = usuarioDAO.listarUsuarios();

        for (Usuario usuario : listaUsuarios) {
            Object[] rowData = {
                    usuario.getIdUsuario(),
                    usuario.getNome(),
                    usuario.getCpf(),
                    usuario.getIdPlano(),
                    DateUtils.formatarParaAplicacao(usuario.getDataDeNascimento()),
                    usuario.getEmail(),
                    usuario.getSenha()
            };
            modeloTabela.addRow(rowData);
        }
    }
}
