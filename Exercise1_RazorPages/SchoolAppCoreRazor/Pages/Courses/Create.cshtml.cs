using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using SchoolAppCoreRazor.Models;

namespace SchoolAppCoreRazor.Pages.Courses
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
            // Check if the Departments table is null or empty
            if (_context.Departments == null || !_context.Departments.Any())
            {
                // Handle the case where there are no departments
                ViewData["DepartmentID"] = new SelectList(new List<SelectListItem>(), "Value", "Text");
                return Page(); // Optionally, inform the user or display a message
            }

            // Populate ViewData with DepartmentID and DepartmentName combined
            ViewData["DepartmentID"] = new SelectList(
                _context.Departments.Select(d => new
                {
                    d.DepartmentID,
                    DisplayText = d.DepartmentID + " - " + d.DepartmentName
                }),
                "DepartmentID",
                "DisplayText"
            );
            return Page();
        }

        [BindProperty]
        public Course Course { get; set; } = default!;

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ViewData["DepartmentID"] = new SelectList(
                    _context.Departments.Select(d => new
                    {
                        d.DepartmentID,
                        DisplayText = d.DepartmentID + " - " + d.DepartmentName
                    }),
                    "DepartmentID",
                    "DisplayText",
                    Course?.DepartmentID
                );
                return Page();
            }

            _context.Courses.Add(Course);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}

