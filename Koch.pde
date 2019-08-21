KochFractal k;

void setup() {
  size(640, 360);
  frameRate(1);  // velocidade da animação(lenta)
  k = new KochFractal();
}

void draw() {
  background(0);
  // desenha o floco de neve
  k.render();
  // Iterate
  k.nextLevel();
  // limita o numero de vezes da animação para 5
  if (k.getCount() > 5) {
    k.restart();
  }
}





// curva de koch
// classe para manutençao do segmento de linhas do floco de neve

class KochFractal {
  PVector start;       // pvector inicial
  PVector end;         //  pvector final
  ArrayList<KochLine> lines;   // lista para manter a contagem das linhas
  int count;
  
  KochFractal() {
    start = new PVector(0,height-20);
    end = new PVector(width,height-20);
    lines = new ArrayList<KochLine>();
    restart();
  }

  void nextLevel() {  
    // Para cada linha que esta no arraylist
    // cria 4 linhas adicionais no arraylist 
    lines = iterate(lines);
    count++;
  }

  void restart() { 
    count = 0;      // resetar contagem
    lines.clear();  // esvaziar o arraylist
    lines.add(new KochLine(start,end));  // adiciona a linha inicial(do fim de um pvector para o outro)  
  }
  
  int getCount() {
    return count;
  }
  
  // desenha as linhas
  void render() {
    for(KochLine l : lines) {
      l.display();
    }
  }

  // 
  //Cria um arraylist vazio Create an empty arraylist
  // Para cada linha já no arraylist:
  //   -Calcula 4 segmentos de linha baseado no algoritmo de Koch 
  //   -Adiciona os 4 segmentos de linha no novo arraylist 
  // Retorna o novo arraylist e ele se torna a nova lista de segmentos para a estrutura. 
  
  //Assim fazendo isso varias vezes, cada linha quebra em 4  linhas , que quebram em mais 4 linhas e assim vai. 
  ArrayList iterate(ArrayList<KochLine> before) {
    ArrayList now = new ArrayList<KochLine>();    // cria uma lista vazia
    for(KochLine l : before) {
      //Calcula 5 koch pvetores 
      PVector a = l.start();                 
      PVector b = l.kochleft();
      PVector c = l.kochmiddle();
      PVector d = l.kochright();
      PVector e = l.end();
      // Faz um segmento de linha entre os pvetores e os adiciona. 
      now.add(new KochLine(a,b));
      now.add(new KochLine(b,c));
      now.add(new KochLine(c,d));
      now.add(new KochLine(d,e));
    }
    return now;
  }

}





//Curva de Koch
// Classe para descrever um segmento de linha no fractal 
// Inclue o metodo para calculara MidPvetores e as linhas de acordo com o algoritmo de Koch.
class KochLine {

  // Dois PVetores 
  // a é o Pvetor da esquerda
  // b  é o pvetor da direita
  PVector a;
  PVector b;

  KochLine(PVector start, PVector end) {
    a = start.copy();
    b = end.copy();
  }

  void display() {
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }

  PVector start() {
    return a.copy();
  }

  PVector end() {
    return b.copy();
  }

 
  PVector kochleft() {
    PVector v = PVector.sub(b, a);
    v.div(3);
    v.add(a);
    return v;
  }    

  // 
  PVector kochmiddle() {
    PVector v = PVector.sub(b, a);
    v.div(3);
    
    PVector p = a.copy();
    p.add(v);
    
    v.rotate(-radians(60));
    p.add(v);
    
    return p;
  }    

  
  PVector kochright() {
    PVector v = PVector.sub(a, b);
    v.div(3);
    v.add(b);
    return v;
  }
}
