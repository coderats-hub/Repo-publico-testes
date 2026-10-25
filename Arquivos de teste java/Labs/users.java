import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class UsuarioController {

    @PostMapping("/usuarios")
    public String criarUsuario(@RequestBody Usuario usuario) {
        return "Usuário criado: " + usuario.nome();
    }
}

record Usuario(String nome, int idade) {}