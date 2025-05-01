<template>
  <div class="container">
    <div class="header-buscar">
      <input
        class="text-buscar"
        v-model="termoBusca"
        placeholder="Digite o nome da operadora"
      />
      <button class="button" @click="buscarOperadora">Buscar</button>
    </div>

    <section v-if="resultados.length > 0" class="resultados">
      <table class="table">
        <thead>
          <tr>
            <th>Nome</th>
            <th>Endereço</th>
            <th>Contato</th>
            <th>Email</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="operadora in resultados" :key="operadora['Registro_ANS']">
            <td>
              {{
                operadora["Nome_Fantasia"] &&
                operadora["Nome_Fantasia"].toLowerCase() !== "nan" &&
                operadora["Nome_Fantasia"].trim() !== ""
                  ? operadora["Nome_Fantasia"]
                  : operadora["Razao_Social"]
              }}
            </td>
            <td>
              {{ operadora["Logradouro"] }} - {{ operadora["Numero"] }},
              {{ operadora["Bairro"] }}, {{ operadora["Cidade"] }} -
              {{ operadora["UF"] }}
            </td>
            <td class="telefone">
              <template v-if="operadora['DDD'] && operadora['Telefone']">
                ({{ operadora["DDD"] }}) {{ operadora["Telefone"] }}
              </template>
              <template v-else-if="operadora['Telefone']">
                {{ operadora["Telefone"] }}
              </template>
              <template v-else> - </template>
            </td>
            <td>{{ operadora["Endereco_eletronico"] }}</td>
          </tr>
        </tbody>
      </table>
    </section>
  </div>
</template>

<script setup>
import { ref } from "vue";
import axios from "axios";

const termoBusca = ref("");
const resultados = ref([]);

const buscarOperadora = async () => {
  try {
    const response = await axios.get("http://127.0.0.1:8000/buscar", {
      params: { nome: termoBusca.value },
    });
    console.log("Dados recebidos:", response.data);
    resultados.value = response.data;
  } catch (error) {
    console.error("Erro ao buscar operadora:", error);
  }
};
</script>
