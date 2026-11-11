using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages.Enrollments
{
    public class CreateModel : PageModel
    {
        private readonly SchoolAppCoreRazor.Models.SchoolContext _context;

        public CreateModel(SchoolAppCoreRazor.Models.SchoolContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            ViewData["CourseID"] = new SelectList(
                _context.Courses.Select(c => new
                {
                    c.CourseID,
                    DisplayText = c.CourseID + " - " + c.Title
                }),
                "CourseID",
                "DisplayText"
            );

            ViewData["StudentID"] = new SelectList(
                _context.Students.Select(s => new
                {
                    s.StudentID,
                    DisplayText = s.StudentID + " - " + s.FirstName + " " + s.LastName
                }),
                "StudentID",
                "DisplayText"
            );

            return Page();
        }

        [BindProperty]
        public Enrollment Enrollment { get; set; } = default!;

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ViewData["CourseID"] = new SelectList(
                    _context.Courses.Select(c => new
                    {
                        c.CourseID,
                        DisplayText = c.CourseID + " - " + c.Title
                    }),
                    "CourseID",
                    "DisplayText",
                    Enrollment?.CourseID
                );

                ViewData["StudentID"] = new SelectList(
                    _context.Students.Select(s => new
                    {
                        s.StudentID,
                        DisplayText = s.StudentID + " - " + s.FirstName + " " + s.LastName
                    }),
                    "StudentID",
                    "DisplayText",
                    Enrollment?.StudentID
                );

                return Page();
            }

            _context.Enrollments.Add(Enrollment);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}

