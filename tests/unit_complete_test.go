package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestUnitComplete(t *testing.T) {
	t.Parallel()

	test := "unit-complete"

	terraformOptions := &terraform.Options{
		TerraformDir: fmt.Sprintf("../%s/tests/%s", os.Getenv("TM_STACK_PATH"), test),
		Upgrade:      true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndPlan(t, terraformOptions)
	// terraform.ApplyAndIdempotent(t, terraformOptions)

	// Replace ApplyAndIdempotent() check with below code if provider and terraform report output changes that
	// can not be prevented due to some bugs in this feature

	// terraform.Apply(t, terraformOptions)

	// stdout := terraform.Plan(t, terraformOptions)

	// resourceCount := terraform.GetResourceCount(t, stdout)
	// assert.Equal(t, 0, resourceCount.Add, "No resources should have been created. Found %d instead.", resourceCount.Add)
	// assert.Equal(t, 0, resourceCount.Change, "No resources should have been changed. Found %d instead.", resourceCount.Change)
	// assert.Equal(t, 0, resourceCount.Destroy, "No resources should have been destroyed. Found %d instead.", resourceCount.Destroy)
}
