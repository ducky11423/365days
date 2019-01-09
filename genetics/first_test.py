import random

n_genomes = 100

class Genome:
    mutation_chance = 0.001

    def __init__(self, genes=None):
        if genes:
            self.genes = genes
        else:
            self.genes = []
            for i in range(10):
                self.genes.append(random.randint(0,9))
    

    def __str__(self):
        return("".join([str(i) for i in self.genes]))

    def get_fitness(self):
        sum = 0

        for i in self.genes:
            sum += i
        
        return sum

    @staticmethod
    def crossover(genome1, genome2):
        new_genes = []

        for i in range(10):
            if random.random() > Genome.mutation_chance:
                new_genes.append(random.randint(0, 9))
            else:
                
                if random.random() > 0.5:
                    new_genes.append(genome1.genes[i])
                else:
                    new_genes.append(genome2.genes[i])
            
        return Genome(genes=new_genes)

genomes = []

for i in range(n_genomes):
        genomes.append(Genome())

generation = 0

while generation < 10000:
    fitness_sum = 0
    for g in genomes:
        fitness_sum += g.get_fitness()

    fitness_avg = fitness_sum/100
    print("Average fitness at generation {:4d}: {:.2f}, top fitness: {}"
        .format(generation,fitness_avg,genomes[0].get_fitness()))

    genomes.sort(key=Genome.get_fitness, reverse=True) # Sort the genomes so the highest fitness is at the top

    genomes = genomes[:20] # selection - cull the bottom genomes as natural selection
    top_genomes = genomes.copy()
    
    for i in range(n_genomes - len(genomes)):
        genome_sample = random.sample(top_genomes, 2) # select 2 of the top genomes
        genomes.append(Genome.crossover(genome_sample[0], genome_sample[1])) # crossover & mutation - 'breed' the genomes

    fitness_sum = 0

    generation += 1