// Sistema Solar

// Angulo de Rotação ao redor do sol e planetas
float theta = 0;

void setup() {
  size(480, 270);
}

void draw() {
  background(255);
  stroke(0);

  // Translada o centro da janela para desenhar o sol .
  translate(width/2, height/2);
  fill(255, 200, 50);
  ellipse(0, 0, 64, 64);

  // A terra que rotaciona o sol 
  pushMatrix();
  rotate(theta);
  translate(100, 0);
  fill(50, 200, 255);
  ellipse(0, 0, 32, 32);

  // Lua #1 rotaciona ao redor da terra 
  // pushMatrix() é chamado para salvar o estado de transformaçao antes de desenhar a lua #1 
  // Desse jeito podemos retornar a terra antes de desenha a Lua #2
  // As duas ruas rotacionam ao redor da terra ( que rotaciona ao redor do sol )
  pushMatrix(); 
  rotate(-theta*4);
  translate(36, 0);
  fill(50, 255, 200);
  ellipse(0, 0, 12, 12);
  popMatrix();

  // Lua 2(também rotaciona ao redor da terra) 
  pushMatrix();
  rotate(theta*2);
  translate(24, 0);
  fill(50, 255, 200);
  ellipse(0, 0, 6, 6);
  popMatrix();

  popMatrix();

  theta += 0.01;
}
