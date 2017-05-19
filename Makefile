grades_ods_dir = grades
grades_html_dir = grades/html-export
grades_html = RoboA.html RoboB.html RoboC.html DataA.html EmbebA.html
grades_html := $(addprefix $(grades_html_dir)/,$(grades_html))

site_html_dir = pages-html
pages_html = homework.html lectures.html grades.html
pages_html := $(addprefix $(site_html_dir)/,$(pages_html))

syllabus_html = syllabus_RA.html #syllabus_RB.html syllabus_RC.html
# syllabus_html += syllabus_EA.html syllabus_DA.html
syllabus_html := $(addprefix $(site_html_dir)/,$(syllabus_html))

site_org_dir= pages-org
export_script = ${site_org_dir}/export-html

all: index.html $(pages_html) $(syllabus_html) #$(grades_html)

index.html: index.org $(export_script)
	$(export_script) $<

$(pages_html): $(site_html_dir)/%.html: $(site_org_dir)/%.org $(export_script)
	$(export_script) $<
	mv $(<:.org=.html) $(site_html_dir)

$(grades_html): $(grades_html_dir)/%.html: $(grades_ods_dir)/%.ods
	soffice --convert-to html $< --outdir $(grades_html_dir)

$(site_html_dir)/syllabus_RA.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-RA.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-RA.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@

$(site_html_dir)/syllabus_RA.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-RA.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-RA.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@
	rm $<-temp

$(site_html_dir)/syllabus_RB.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-RB.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-RB.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@
	rm $<-temp

$(site_html_dir)/syllabus_RC.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-RC.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-RC.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@
	rm $<-temp

$(site_html_dir)/syllabus_EA.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-EA.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-EA.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@
	rm $<-temp

$(site_html_dir)/syllabus_DB.html: $(site_org_dir)/syllabus.org $(site_org_dir)/outline-DA.org $(export_script)
	sed -r 's/<<<outline-file>>>/#+INCLUDE: outline-DA.org/' $< > $<-temp
	$(export_script) $<-temp
	mv $(site_org_dir)/syllabus.html $@
	rm $<-temp

clean:
	rm index.html $(pages_html) $(grades_html) $(grades_html_dir)/*.png
