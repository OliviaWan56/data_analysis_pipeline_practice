# Define variables
TEXT_FILES = data/isles.txt data/abyss.txt data/last.txt data/sierra.txt
COUNT_FILES = results/isles.dat results/abyss.dat results/last.dat results/sierra.dat
PLOT_FILES = results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
REPORT = report/count_report.html

# Default target
all: $(PLOT_FILES) $(REPORT)

# Step 1: Word count for each novel
results/%.dat: data/%.txt scripts/wordcount.py
	python scripts/wordcount.py --input_file=$< --output_file=$@

# Step 2: Generate plots for each word count file
results/figure/%.png: results/%.dat scripts/plotcount.py
	python scripts/plotcount.py --input_file=$< --output_file=$@

# Step 3: Render the report
$(REPORT): report/count_report.qmd $(COUNT_FILES) $(PLOT_FILES)
	quarto render report/count_report.qmd

# Clean target to reset the repository
clean:
	rm -f $(COUNT_FILES) $(PLOT_FILES) $(REPORT)
