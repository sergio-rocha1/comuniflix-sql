package br.com.comuniflix.interfaces;

import br.com.comuniflix.dao.UsuarioDAO;
import br.com.comuniflix.model.Usuario;
import br.com.comuniflix.utils.DateUtils;
import br.com.comuniflix.utils.HibernateUtils;
import org.hibernate.SessionFactory;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class CadastroFrame extends JFrame {
    private JLabel etiquetaNome;
    private JTextField campoNome;
    private JLabel etiquetaCPF;
    private JTextField campoCPF;
    private JLabel etiquetaPlano;
    private JTextField campoPlano;
    private JLabel etiquetaDataNascimento;
    private JTextField campoDataNascimento;
    private JLabel etiquetaEmail;
    private JTextField campoEmail;
    private JLabel etiquetaSenha;
    private JPasswordField campoSenha;
    private JButton botaoCadastrar;
    private JButton botaoVoltar;

    public CadastroFrame() {
        setTitle("Cadastro");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(1000, 800); // Aumenta o tamanho da tela
        setLayout(null);
        getContentPane().setBackground(Color.BLACK); // Define o fundo preto

        etiquetaNome = new JLabel("Nome:");
        campoNome = new JTextField();
        etiquetaCPF = new JLabel("CPF:");
        campoCPF = new JTextField();
        etiquetaPlano = new JLabel("ID do Plano:");
        campoPlano = new JTextField();
        etiquetaDataNascimento = new JLabel("Data de Nascimento:");
        campoDataNascimento = new JTextField();
        etiquetaEmail = new JLabel("Email:");
        campoEmail = new JTextField();
        etiquetaSenha = new JLabel("Senha:");
        campoSenha = new JPasswordField();
        botaoCadastrar = new JButton("Cadastrar");
        botaoVoltar = new JButton("Voltar");

        etiquetaNome.setForeground(Color.WHITE); // Define o texto em branco
        etiquetaCPF.setForeground(Color.WHITE);
        etiquetaPlano.setForeground(Color.WHITE);
        etiquetaDataNascimento.setForeground(Color.WHITE);
        etiquetaEmail.setForeground(Color.WHITE);
        etiquetaSenha.setForeground(Color.WHITE);
        botaoCadastrar.setForeground(Color.BLACK);
        botaoVoltar.setForeground(Color.BLACK);

        int larguraComponente = 600; // Largura dos campos de entrada
        int alturaComponente = 40; // Altura dos campos de entrada

        // Calcula as coordenadas para centralizar os componentes à direita
        int x = getWidth() / 2 - larguraComponente / 2 + 200;
        int y = (getHeight() - alturaComponente * 9) / 2;

        etiquetaNome.setBounds(x, y, 100, 30);
        campoNome.setBounds(x + 110, y, larguraComponente, alturaComponente);
        etiquetaCPF.setBounds(x, y + 40, 100, 30);
        campoCPF.setBounds(x + 110, y + 40, larguraComponente, alturaComponente);
        etiquetaPlano.setBounds(x, y + 80, 100, 30);
        campoPlano.setBounds(x + 110, y + 80, larguraComponente, alturaComponente);
        etiquetaDataNascimento.setBounds(x, y + 120, 150, 30);
        campoDataNascimento.setBounds(x + 160, y + 120, larguraComponente - 50, alturaComponente);
        etiquetaEmail.setBounds(x, y + 160, 100, 30);
        campoEmail.setBounds(x + 110, y + 160, larguraComponente, alturaComponente);
        etiquetaSenha.setBounds(x, y + 200, 100, 30);
        campoSenha.setBounds(x + 110, y + 200, larguraComponente, alturaComponente);
        botaoCadastrar.setBounds(x + 200, y + 250, 200, 40); // Aumenta o tamanho do botão
        botaoVoltar.setBounds(x + 450, y + 250, 200, 40); // Aumenta o tamanho do botão

        add(etiquetaNome);
        add(campoNome);
        add(etiquetaCPF);
        add(campoCPF);
        add(etiquetaPlano);
        add(campoPlano);
        add(etiquetaDataNascimento);
        add(campoDataNascimento);
        add(etiquetaEmail);
        add(campoEmail);
        add(etiquetaSenha);
        add(campoSenha);
        add(botaoCadastrar);
        add(botaoVoltar);

        botaoVoltar.addActionListener(e -> {
            dispose(); // Fecha a janela de cadastro
        });

        // Adiciona o nome "COMUNIFLIX" em vermelho centralizado na parte superior da janela
        JLabel etiquetaTitulo = new JLabel("COMUNIFLIX");
        etiquetaTitulo.setForeground(Color.RED);
        etiquetaTitulo.setFont(new Font("Arial", Font.BOLD, 60));
        int larguraTitulo = 400; // Largura do letreiro
        int alturaTitulo = 80; // Altura do letreiro
        int xTitulo = (getWidth() - larguraTitulo) / 2; // Coordenada X para centralização horizontal
        int yTitulo = 50; // Coordenada Y para posicionamento na parte superior
        etiquetaTitulo.setBounds(xTitulo, yTitulo, larguraTitulo, alturaTitulo);
        add(etiquetaTitulo);

        botaoCadastrar.addActionListener(e -> cadastrarUsuario());
    }

    private void cadastrarUsuario() {

        // Recupera os valores dos campos preenchidos
        String nome = campoNome.getText();
        String cpf = campoCPF.getText();
        String plano = campoPlano.getText();
        String email = campoEmail.getText();
        String senha = new String(campoSenha.getPassword()); // Recupera a senha como um array de caracteres
        LocalDate dataDeNascimento = LocalDate.parse(campoDataNascimento.getText(), DateTimeFormatter.ofPattern("dd/MM/yyyy"));

        // Cria um novo objeto Usuario com os valores dos campos preenchidos
        Usuario novoUsuario = new Usuario();
        novoUsuario.setNome(nome);
        novoUsuario.setCpf(new BigDecimal(cpf));
        novoUsuario.setIdPlano(new BigDecimal(plano));
        novoUsuario.setEmail(email);
        novoUsuario.setSenha(senha);
        novoUsuario.setDataDeNascimento(DateUtils.formatarParaBD(dataDeNascimento));

        // Verifica se todos os campos estão preenchidos
        if (nome.isEmpty() || cpf.isEmpty() || plano.isEmpty() || campoDataNascimento.getText().isEmpty() || email.isEmpty() || senha.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Por favor, preencha todos os campos.", "Erro", JOptionPane.ERROR_MESSAGE);
            return;
        }

        // Insere o usuário no banco de dados
        inserirNoBanco(novoUsuario);

        // Mostra uma mensagem de sucesso
        JOptionPane.showMessageDialog(null, "Usuário cadastrado com sucesso!", "Cadastro", JOptionPane.INFORMATION_MESSAGE);

        // Limpa os campos para o próximo cadastro
        limparCampos();
    }

    public void limparCampos() {
        // Limpa os campos após cadastrar o usuário
        campoNome.setText("");
        campoCPF.setText("");
        campoPlano.setText("");
        campoDataNascimento.setText("");
        campoEmail.setText("");
        campoSenha.setText("");
    }

    public void inserirNoBanco(Usuario novoUsuario) {
        // Salva o usuário no banco de dados utilizando o método salvarUsuario do DAO
        SessionFactory sessionFactory = HibernateUtils.getSessionFactory();
        UsuarioDAO usuarioDAO = new UsuarioDAO(sessionFactory);
        usuarioDAO.salvarUsuario(novoUsuario);
    }


}