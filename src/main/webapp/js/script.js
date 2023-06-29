document.addEventListener("DOMContentLoaded", function() {
    const gif = document.getElementById("gif");
    gif.addEventListener("animationend", function() {
        gif.style.visibility = "hidden";
    });
})

document.getElementById("btn-login").addEventListener("click", function(event) {
    event.preventDefault(); // Evita o comportamento padrão do botão

    // Obter os valores dos campos de e-mail e senha
    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    // Realizar a chamada ao backend para verificar as credenciais
    fetch('/controllers/Login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            email: email,
            senha: senha
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Credenciais válidas
                alert("Login bem-sucedido!");
                // Aqui você pode realizar outras ações, como redirecionar o usuário para outra página, etc.
            } else {
                // Credenciais inválidas
                alert("Credenciais inválidas. Por favor, insira um e-mail e senha válidos.");
            }
        })
        .catch(error => {
            console.error('Ocorreu um erro:', error);
        });
});
