package br.com.comuniflix.interfaces;

import br.com.comuniflix.model.Usuario;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class TelaInicial extends JFrame {

        public TelaInicial() {
            // Criação do Painel da tela
            setTitle("Gerenciamento de Usuários");
            setSize(500, 500);
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            getContentPane().setBackground(Color.BLACK); // Define o fundo preto

            JPanel painelBotoes = new JPanel();
            painelBotoes.setLayout(new GridLayout(2, 1));
            painelBotoes.setBackground(Color.BLACK); // Define o fundo preto para o painel dos botões

            JButton botaoCriarUsuario = new JButton("Criar usuário novo");
            botaoCriarUsuario.setBackground(Color.WHITE); // Define a cor de fundo do botão como branco
            botaoCriarUsuario.addActionListener(e -> {
                // Chama a classe CadastroFrame quando o botão "Criar usuário novo" for clicado
                SwingUtilities.invokeLater(() -> {
                    CadastroFrame cadastroFrame = new CadastroFrame();
                    cadastroFrame.setVisible(true);
                });
            });

            JButton botaoListarUsuarios = new JButton("Listar usuários existentes");
            botaoListarUsuarios.setBackground(Color.WHITE); // Define a cor de fundo do botão como branco
            botaoListarUsuarios.addActionListener(e -> {
                // Chama a classe TelaListagemUsuarios quando o botão "Listar usuários existentes" for clicado
                SwingUtilities.invokeLater(() -> {
                    TelaListagemUsuariosApp telaListagemUsuarios = new TelaListagemUsuariosApp();
                    telaListagemUsuarios.setVisible(true);
                });
            });

            painelBotoes.add(botaoCriarUsuario);
            painelBotoes.add(botaoListarUsuarios);

            add(painelBotoes, BorderLayout.SOUTH);

            // Adiciona o letreiro "COMUNIX" em vermelho centralizado na parte superior da janela
            JLabel tituloLabel = new JLabel("COMUNIFLIX");
            tituloLabel.setForeground(Color.RED);
            tituloLabel.setFont(new Font("Arial", Font.BOLD, 24));
            tituloLabel.setHorizontalAlignment(SwingConstants.CENTER);
            add(tituloLabel, BorderLayout.CENTER);

            setVisible(true);
        }
}