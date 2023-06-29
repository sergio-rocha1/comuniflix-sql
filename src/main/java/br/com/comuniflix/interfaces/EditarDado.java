package br.com.comuniflix.interfaces;

import br.com.comuniflix.dao.UsuarioDAO;
import br.com.comuniflix.model.Usuario;
import br.com.comuniflix.utils.HibernateUtils;
import br.com.comuniflix.utils.DateUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class EditarDado extends JFrame {

    private Usuario usuario;
    private JTextField campoNome;
    private JTextField campoCPF;
    private JTextField campoPlano;
    private JTextField campoDataNascimento;
    private JTextField campoEmail;
    private JPasswordField campoSenha;

    private TelaListagemUsuariosApp telaListagemUsuariosApp; // Referência para a instância de TelaListagemUsuariosApp

    public EditarDado(Usuario usuario, TelaListagemUsuariosApp telaListagemUsuariosApp) {
        // Recebe os valores do construtor e armazena nos atributos da classe para uso
        this.telaListagemUsuariosApp = telaListagemUsuariosApp;
        this.usuario = usuario;

        // Criação do Painel da tela
        setTitle("Editar Dado");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(1000, 800);
        setLayout(null);
        getContentPane().setBackground(Color.BLACK); // Define o fundo preto

        // Campos de entrada carregados com a informação vinda da classe "Usuario"
        JLabel rotuloNome = new JLabel("Nome:");
        campoNome = new JTextField(usuario.getNome());
        JLabel rotuloCPF = new JLabel("CPF:");
        campoCPF = new JTextField(String.valueOf(usuario.getCpf()));
        JLabel rotuloPlano = new JLabel("ID do Plano:");
        campoPlano = new JTextField(String.valueOf(usuario.getIdPlano()));
        JLabel rotuloDataNascimento = new JLabel("Data de Nascimento:");
        campoDataNascimento = new JTextField(DateUtils.formatarParaAplicacao(usuario.getDataDeNascimento()));
        JLabel rotuloEmail = new JLabel("Email:");
        campoEmail = new JTextField(usuario.getEmail());
        JLabel rotuloSenha = new JLabel("Senha:");
        campoSenha = new JPasswordField(usuario.getSenha());

        // Criação dos Botões
        JButton botaoCancelar = new JButton("Cancelar");
        JButton botaoConcluir = new JButton("Concluir");

        int campoWidth = 600; // Largura dos campos de entrada
        int campoHeight = 40; // Altura dos campos de entrada

        int x = 100; // Coordenada X para alinhar os componentes
        int y = 100; // Coordenada Y para posicionar os componentes

        // Posicionamento dos componentes na janela
        rotuloNome.setBounds(x, y, 100, 25);
        campoNome.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 60;

        rotuloCPF.setBounds(x, y, 100, 25);
        campoCPF.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 60;

        rotuloPlano.setBounds(x, y, 100, 25);
        campoPlano.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 60;

        rotuloDataNascimento.setBounds(x, y, 130, 25);
        campoDataNascimento.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 60;

        rotuloEmail.setBounds(x, y, 100, 25);
        campoEmail.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 60;

        rotuloSenha.setBounds(x, y, 100, 25);
        campoSenha.setBounds(x + 150, y, campoWidth, campoHeight);
        y += 100;

        botaoCancelar.setBounds(280, y, 150, 40);
        botaoConcluir.setBounds(460, y, 150, 40);

        // Adicionando todos os componentes configurados na tela.
        add(rotuloNome);
        add(campoNome);
        add(rotuloCPF);
        add(campoCPF);
        add(rotuloPlano);
        add(campoPlano);
        add(rotuloDataNascimento);
        add(campoDataNascimento);
        add(rotuloEmail);
        add(campoEmail);
        add(rotuloSenha);
        add(campoSenha);
        add(botaoCancelar);
        add(botaoConcluir);

        // Adiciona o letreiro "COMUNIFLIX" em vermelho centralizado na parte superior da janela
        JLabel rotuloTitulo = new JLabel("COMUNIFLIX");
        rotuloTitulo.setForeground(Color.RED);
        rotuloTitulo.setFont(new Font("Arial", Font.BOLD, 36));
        rotuloTitulo.setHorizontalAlignment(SwingConstants.CENTER);
        rotuloTitulo.setBounds(0, 20, getWidth(), 50);
        add(rotuloTitulo);

        // Evento que ao clicar no botão "Cancelar" a tela é fechada
        botaoCancelar.addActionListener(e -> dispose());

        // Evento que ao clicar no botão "Concluir" a tela é fechada
        botaoConcluir.addActionListener(e -> {

            atualizarDadosBanco();

            // Exiba uma mensagem de sucesso
            JOptionPane.showMessageDialog(null, "Usuário atualizado com sucesso");

            // Chama o método atualizarTabela() na referência de TelaListagemUsuariosApp
            telaListagemUsuariosApp.atualizarTabela();

            dispose(); // Fecha a janela de edição
        });
    }

    public void atualizarDadosBanco() {
        // Atualiza os dados do usuário com base nos campos de entrada
        usuario.setNome(campoNome.getText());
        usuario.setCpf(new BigDecimal(campoCPF.getText()));
        usuario.setIdPlano(new BigDecimal(campoPlano.getText()));
        System.out.println("Valor do campoDataNascimento: " + campoDataNascimento.getText());
        usuario.setDataDeNascimento(DateUtils.formatarParaBD(LocalDate.parse(campoDataNascimento.getText(), DateTimeFormatter.ofPattern("dd/MM/yyyy"))));
        usuario.setEmail(campoEmail.getText());
        usuario.setSenha(new String(campoSenha.getPassword()));

        // Chama o método da classe UsuarioDAO para salvar as alterações
        UsuarioDAO usuarioDAO = new UsuarioDAO(HibernateUtils.getSessionFactory());
        usuarioDAO.atualizarUsuario(usuario);
    }
}
